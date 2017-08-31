set nocompatible
filetype off
set shell=bash

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Plugin 'VundleVim/Vundle.vim'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
" /Bundles

call vundle#end()

filetype plugin indent on

set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set magic

set number

syntax on

inoremap <C-@> <C-x><C-o>