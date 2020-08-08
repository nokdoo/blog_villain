#!/bin/sh
REPO="https://github.com/nokdoot/blog_villain"

missing () {
    echo '';
    echo 'haha';
    echo "! $1 is missing.";
    echo '';
    exit 1;
}

init_bins () {
    for bin in "$@";
    do
        location=$(which "$bin");
        [[ -z "$location" ]] && missing "$bin"
        export "$bin"="$location";
    done
}

git_clone () {
    echo "> $git clone --branch master $REPO";
    "$git" clone --branch master "$REPO"
}

init_bins 'perl' 'git';
# cd로 이동해서 설치하는 기능 추가
