#!/bin/sh

do_compress() {
    out_name="$1"
    shift
    out_format="$1"
    shift

    echo "${out_name}"
    echo "${out_format}"
    echo "$@"
    # default openssl enc -aes256 use `-md sha256`, can use sha512 get more secure and faster
    tar --"${out_format}" -cf - "$@" | openssl enc -aes256 -a -pbkdf2 -salt > "${out_name}".aes256.base64
}

if [ $# -lt 3 ];    then
    echo "useage: $0 out_name compress_format input_files"
    echo "compress_format:"
    echo "      1. zstd"
    echo "      2. gzip"
    echo "      3. xz"
    echo "      4. bzip2"
    echo "      5. lzip"
    echo "      6. lzma"
    echo "      7. lzop"
    echo "      8. compress"
else
    do_compress "$@"
fi
