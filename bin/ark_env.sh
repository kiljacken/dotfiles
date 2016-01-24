#!/bin/bash

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

# check llvm version
check_llvm_version() {
	which llvm-config &> /dev/null || die "No LLVM detected (llvm-config not in path)"

	llvm_version=`llvm-config --version`
	llvm_major=`echo $llvm_version | cut -d. -f1`
	llvm_minor=`echo $llvm_version | cut -d. -f2`
	llvm_revision=`echo $llvm_version | cut -d. -f3`
	llvm_ver_joined="$llvm_major$llvm_minor$llvm_revision"

	info "Found LLVM $llvm_major.$llvm_minor.$llvm_revision"
}

# setup gopath
setup_gopath() {
	[ -d $GOPATH ] || mkdir -p $GOPATH/{src,bin,pkg}
	export PATH=$GOPATH/bin:$PATH

	info "Gopath established as: $GOPATH"
}

# checkout llvm
checkout_llvm() {
	check_llvm_version

	info "Checking out llvm source-tree"
	svn_path="https://llvm.org/svn/llvm-project/llvm/tags/RELEASE_$llvm_ver_joined/final"
	svn co $svn_path $GOPATH/src/llvm.org/llvm || die "Failed to checkout llvm source"	
	$GOPATH/src/llvm.org/llvm/bindings/go/build.sh
}

# setup cgo
install_llvm() {
	check_llvm_version

	#info "Setting up CGO flags"
	#export CGO_CPPFLAGS="`llvm-config --cppflags`"
	#export CGO_LDFLAGS="`llvm-config --ldflags --libs --system-libs all`"
	#export CGO_CXXFLAGS=-std=c++11

	# install llvm bindings
	info "Installing llvm bindings"
	go install -v llvm.org/llvm/bindings/go/llvm || die "Failed to install llvm bindings to Gopath"	
}

# checkout ark
checkout_ark() {
	info "Fetching ark"
	go get -v github.com/ark-lang/ark/... || die "Failed to fetch ark 
source"
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
