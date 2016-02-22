#!/usr/bin/env bash

# variables
export GOPATH=$HOME/ark_go

# functions
info() {
  echo "[ ] $@"
}

die() {
  echo -e "\e[41m[!] \e[4m$@\e[0m"
  exit 1
}

# check arguments
fetch_llvm=1
setup_llvm=1
fetch_ark=1
setup_ark=1

for arg in $@; do
	case $arg in
		nodl)
			info "Disabling downloads"
			fetch_llvm=0
			fetch_ark=0
			;;

		envonly)
			info "Disabling downloads and builds"
			fetch_llvm=0
			fetch_ark=0
			setup_llvm=0
			setup_ark=0
			;;
	esac
done

# setup gopath
setup_gopath() {
	[ -d $GOPATH ] || mkdir -p $GOPATH/{src,bin,pkg}
	export PATH=$GOPATH/bin:$PATH

	info "Gopath established as: $GOPATH"
}

# checkout llvm bindings
checkout_llvm() {
        rm -rf $GOPATH/src/github.com/ark-lang/go-llvm
        git clone git@github.com:ark-lang/go-llvm.git $GOPATH/src/github.com/ark-lang/go-llvm
}

# setup llvm bindings
install_llvm() {
        cd $GOPATH/src/github.com/ark-lang/go-llvm
        ./build.sh
        cd -
}

# checkout ark
checkout_ark() {
	info "Fetching ark"
        rm -rf $GOPATH/src/github.com/ark-lang/ark
        git clone git@github.com:ark-lang/ark.git $GOPATH/src/github.com/ark-lang/ark
}

# setup ark
install_ark() {
	info "Building ark"
	go install -v github.com/ark-lang/ark/... || die "Failed to build ark"
}

# run things
setup_gopath

[[ "$fetch_llvm" == "1" ]] && checkout_llvm
[[ "$setup_llvm" == "1" ]] && install_llvm

[[ "$fetch_ark" == "1" ]] && checkout_ark
[[ "$setup_ark" == "1" ]] && install_ark

cd $GOPATH/src/github.com/ark-lang/ark
#echo "Launching $SHELL..."
#$SHELL
