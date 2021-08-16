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

It aims to be compatible with a wide range of Vim versions (back to Vim
7.2 with the "tiny" feature set), providing reasonable fallback behavior
whenever functionality is unavailable.

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

    -   If using [an `+eval`-less Vim][3]:

        -   Make sure `$HOME/.vimrc.local` and `$HOME/.gvimrc.local`
            exist, even if one or both are empty.  This suppresses
            a harmless but vexing "Can't open file" message.

            ```sh
            touch ~/.vimrc.local ~/.gvimrc.local
            ```


## Customization ##

(Obviously the working copy can be modified arbitrarily, but the
customizations described here are not tracked by Git.)

To add settings that are not suitable for the repository, create and
populate `$HOME/.vimrc.local` and `$HOME/.gvimrc.local`.  These are
sourced at the ends of `$HOME/.vim/vimrc` and `$HOME/.vim/gvimrc`, so
they can build on or override settings from those files.  (See
`vimrc.local.sample` and `gvimrc.local.sample`.)

To use packages that are not suitable for the repository, place them
anywhere in `$HOME/.vim/pack` other than `versioned`.


## Development ##

Look to the [Google Vimscript Guide][7].  Although it's mostly about
writing plugins, it contains some recommendations that are useful here,
especially under "[Portability][8]", "[Variables][9]", "[Strings][10]",
"[Settings][11]", and "[Functions][12]".

Maintain portability across Vim versions and feature sets; the baseline
is Vim 7.2 with the "tiny" feature set.  The most disruptive requirement
is probably accommodating a [lack of `+eval`][3] (outside of plugins,
which are not used at all in that case).

-   Establish portable defaults first, then override them later if
    desired.  This can be an adequate `+eval`-less replacement for
    `if`/`else` or `try`/`catch`, as long as the overriding code fails
    without side effects or is conditionalized in another way.

    ```vim
    set listchars=tab:>-          " Works in 7.2.
    silent set listchars=tab:-->  " Fails without patch 8.1.0795.
    ```

    ```vim
    set showbreak=>>>   " vimrc: Enable this by default.
    set showbreak&      " gvimrc: Reset it in the GUI.
    ```

-   Use `silent!` to run most commands that don't need `+eval`, do have
    other requirements, and fail loudly if those are not met.

    ```vim
    silent! syntax enable         " Needs +syntax.
    silent! set formatoptions+=j  " Needs patch 7.3.541.
    ```

-   Use `if` to protect code that requires `+eval`; without `+eval`,
    everything between `if` and `endif` is ignored, including the
    condition.  Use `if 1` unless there are more conditions to impose.

    ```vim
    " Calling functions requires +eval.  We also need +autocmd, so check
    " for that while I'm at it.
    if has('autocmd')
        autocmd EncodingChanged * call s:EncodingChangedHandler()
    endif
    ```

    Also use it to conditionalize code that doesn't fail cleanly on its
    own.  Since this code will never run without `+eval`, make sure the
    defaults are reasonable.

    ```vim
    set softtabstop=4
    if v:version > 703 || (v:version == 703 && has('patch693'))
        " This throws an error if -1 is invalid but sets 'softtabstop'
        " to 0 without warning.  Rude!
        set softtabstop=-1
    endif
    ```

-   Given two equivalent constructs, prefer the one that works with
    older versions of Vim.  For example, `has('patch-8.1.0759')` is nice
    but requires patch 7.4.237; do it [the long way][13] instead.

    ```vim
    if v:version > 801 || (v:version == 801 && has('patch0759'))
        let s:tmp .= ",tab:\xe2\x8e\xaf\xe2\x8e\xaf\xe2\x86\x92"
    else
    ```


## Legal ##

This work is published from the United States of America using the [CC0
1.0 Universal Public Domain Dedication][14].


 [1]: https://www.vim.org
 [2]: https://ftp.nluug.nl/pub/vim/patches/7.3/7.3.1178
 [3]: https://vimhelp.org/eval.txt.html#no-eval-feature
 [7]: https://google.github.io/styleguide/vimscriptfull.xml
 [8]: https://google.github.io/styleguide/vimscriptfull.xml#Portability
 [9]: https://google.github.io/styleguide/vimscriptfull.xml#Variables
[10]: https://google.github.io/styleguide/vimscriptfull.xml#Strings
[11]: https://google.github.io/styleguide/vimscriptfull.xml#Settings
[12]: https://google.github.io/styleguide/vimscriptfull.xml#Functions
[13]: https://vimhelp.org/eval.txt.html#has-patch
[14]: https://creativecommons.org/publicdomain/zero/1.0
