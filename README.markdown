<!--
    README.markdown
    ---------------

    Written in 2020-2021 by Lawrence Velázquez <vq@larryv.me>.

    To the extent possible under law, the author(s) have dedicated all
    copyright and related and neighboring rights to this software to the
    public domain worldwide.  This software is distributed without any
    warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software.  If not, see
    <http://creativecommons.org/publicdomain/zero/1.0/>.

    SPDX-License-Identifier: CC0-1.0
-->


# vimfiles #

This is my [Vim][1] configuration.  It used to be worse.

Here begins a series of notes to myself.


## Installation ##

A Unix-like operating system and Bourne-adjacent shell are assumed.
Error-checking is omitted for brevity.

1.  Clone this repository at `$HOME/.vim`, which shouldn't exist yet.
    If it does, delete it or move it somewhere else.

    ```sh
    # Git 1.7.4.1 and later
    git clone --recurse-submodules https://github.com/larryv/vimfiles.git ~/.vim
    ```

    ```sh
    # Git 1.6.5 and later
    git clone --recursive https://github.com/larryv/vimfiles.git ~/.vim
    ```

    ```sh
    # Otherwise
    git clone https://github.com/larryv/vimfiles.git ~/.vim
    cd ~/.vim
    git submodule update --init --recursive
    ```

    Alternately, clone it somewhere else and create `$HOME/.vim` as
    a link to it.

    ```sh
    git clone --recurse-submodules https://github.com/larryv/vimfiles.git /somewhere/else
    ln -s /somewhere/else ~/.vim
    ```

2.  Certain uncommon setups require additional steps.

    -   If using Vim 7.2 or earlier or 7.3 without [patch 1178][2],
        create `$HOME/.vimrc` and `$HOME/.gvimrc` as links to
        `.vim/vimrc` and `.vim/gvimrc`.

        ```sh
        ln -s .vim/vimrc ~/.vimrc
        ln -s .vim/gvimrc ~/.gvimrc
        ```


## Customization ##

(Obviously the working copy can be modified arbitrarily, but the
customizations described here are not tracked by Git.)

To add settings that are not suitable for the repository, create and
populate `$HOME/.vimrc.local` and `$HOME/.gvimrc.local`.  These are
sourced at the ends of `$HOME/.vim/vimrc` and `$HOME/.vim/gvimrc`, so
they can build on or override settings from those files.

To use packages that are not suitable for the repository, place them
anywhere in `$HOME/.vim/pack` other than `versioned`.


## Development ##

Look to the [Google Vimscript Guide][7].  Although it's mostly about
writing plugins, it contains some recommendations that are useful here,
especially under "[Portability][8]", "[Variables][9]", "[Strings][10]",
"[Settings][11]", and "[Functions][12]".


## Legal ##

This work is published from the United States of America using the [CC0
1.0 Universal Public Domain Dedication][14].


 [1]: https://www.vim.org
 [2]: https://ftp.nluug.nl/pub/vim/patches/7.3/7.3.1178
 [7]: https://google.github.io/styleguide/vimscriptfull.xml
 [8]: https://google.github.io/styleguide/vimscriptfull.xml#Portability
 [9]: https://google.github.io/styleguide/vimscriptfull.xml#Variables
[10]: https://google.github.io/styleguide/vimscriptfull.xml#Strings
[11]: https://google.github.io/styleguide/vimscriptfull.xml#Settings
[12]: https://google.github.io/styleguide/vimscriptfull.xml#Functions
[14]: https://creativecommons.org/publicdomain/zero/1.0
