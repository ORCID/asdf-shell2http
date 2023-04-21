#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/msoap/shell2http"
TOOL_NAME="shell2http"
TOOL_TEST="shell2http --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

list_all_versions() {
  list_github_tags
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  local platform="$(echo $(uname) | tr '[:upper:]' '[:lower:]')"

  local arch_test=$(uname -m)

  if [[ "$arch_test" = x86_64 ]]; then
    arch=amd64
  else
    arch=$arch_test
  fi

  url="$GH_REPO/releases/download/v${version}/shell2http_${version}_${platform}_${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/$tool_cmd "$install_path"

    chmod +x "$install_path/$tool_cmd"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful in $install_path!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
