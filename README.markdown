<!--
    README.markdown
    ---------------

    SPDX-License-Identifier: CC0-1.0

    Written in 2020-2021, 2023, 2025 by Lawrence Velazquez
    <vq@larryv.me>.

    To the extent possible under law, the author has dedicated all
    copyright and related and neighboring rights to this software to the
    public domain worldwide.  This software is distributed without any
    warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software.  If not, see
    <https://creativecommons.org/publicdomain/zero/1.0/>.
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

1.  Decide where to put the configuration.  The most compatible location
    is `$HOME/.vim`, which has headed the default Unix `runtimepath`
    since `runtimepath` was introduced in Vim 6.0.  Vim 9.2 and later
    and Vim 9.1 with patches [327][2], [337][3], and [345][4] can also
    use [`$XDG_CONFIG_HOME/vim` or `$HOME/.config/vim`][5].

    The rest of this document uses "`${vimfiles?}`" to stand in for the
    chosen path.  [In example commands][6], it can be replaced with the
    path directly or used as-is after setting the `vimfiles` variable to
    the path.

2.  Download this repository to `${vimfiles?}`, which shouldn't exist yet.
    If it does, delete it or move it somewhere else first.

    -   [Git 1.7.4.1][7] or later:

        ```sh
        git clone --recurse-submodules https://github.com/larryv/vimfiles.git "${vimfiles?}"
        ```

    -   [Git 1.6.5][8] or later:

        ```sh
        git clone --recursive https://github.com/larryv/vimfiles.git "${vimfiles?}"
        ```

    -   [Git 1.6.1][9] or later:

        ```sh
        git clone https://github.com/larryv/vimfiles.git "${vimfiles?}" &&
        CDPATH= cd -- "${vimfiles?}" &&
        git submodule update --init &&
        git submodule foreach git submodule update --init
        ```

    -   Git 1.5.6 or later: exercise for the reader, who will have to do
        without `git submodule foreach`.

    -   Git 1.5.3 or later: exercise for the reader, who will have to
        [do without `git submodule update --init`][10].

    -   Primordial Git: exercise for the reader, who will have to [do
        without `git submodule`][11].

    -   No Git: exercise for the reader, who will have to [do without
        `git`][12].

    Alternatively, put it somewhere else and create `${vimfiles?}` as
    a link to it.

    ```sh
    git clone --recurse-submodules https://github.com/larryv/vimfiles.git /somewhere/else &&
    ln -s /somewhere/else "${vimfiles?}"
    ```

3.  Take additional steps as required or desired.

    -   Ensure `vimrc.local` and `gvimrc.local` exist in `${vimfiles?}`,
        preventing the `:runtime` commands in `${vimfiles?}/vimrc` and
        `${vimfiles?}/gvimrc` from sourcing identically named files in
        other `runtimepath` directories.  (The chances that such files
        are present is negligible but nonzero.)

        ```sh
        touch -- "${vimfiles?}/vimrc.local" "${vimfiles?}/gvimrc.local"
        ```

    -   If using Vim 7.2 or earlier or 7.3 without [patch 1178][13],
        create `$HOME/.vimrc` and `$HOME/.gvimrc` as links to
        `${vimfiles?}/vimrc` and `${vimfiles?}/gvimrc`, respectively,
        so Vim has something to read.

        ```sh
        ln -s -- "${vimfiles?}/vimrc" ~/.vimrc
        ln -s -- "${vimfiles?}/gvimrc" ~/.gvimrc
        ```

    -   If using [an `+eval`-less Vim][14]:

        -   If using Vim 7.1 or later or 7.0 with patches [234][15] and
            [235][16], reenable modelines in `${vimfiles?}/vimrc.local`.
            They are disabled by default to mitigate [CVE-2007-2438][17].

            ```vim
            set modeline&
            set modelines&
            ```


## Customization ##

(Obviously the working copy can be modified arbitrarily, but the
customizations described here are not tracked by Git.)

To enact settings that shouldn't go into version control, create and
populate `${vimfiles?}/vimrc.local` and `${vimfiles?}/gvimrc.local`.
These are sourced at or near the ends of `${vimfiles?}/vimrc` and
`${vimfiles?}/gvimrc`, so they can build on or override settings from
those files.  (See `vimrc.local.sample` and `gvimrc.local.sample`.)

To use packages that are not suitable for the repository, place them
anywhere in `${vimfiles?}/pack` other than `versioned`.


## Development ##

Look to the [Google Vimscript Guide][18].  Although it's mostly about
writing plugins, it contains some recommendations that are useful here,
especially under "[Portability][19]", "[Variables][20]", "[Strings][21]",
"[Settings][22]", and "[Functions][23]".

Maintain portability across Vim versions and feature sets; the baseline
is Vim 7.2 with the "tiny" feature set.  The most disruptive requirement
is probably accommodating a [lack of `+eval`][14] (outside of plugins,
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
    silent! set formatoptions+=j  " Needs patch 7.3.541.
    silent! syntax enable         " Needs +syntax.
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
    but requires patch 7.4.237; do it [the long way][24] instead.

    ```vim
    if v:version > 801 || (v:version == 801 && has('patch0759'))
        let s:tmp .= ",tab:\xe2\x8e\xaf\xe2\x8e\xaf\xe2\x86\x92"
    else
    ```


## Legal ##

To the extent possible under law, [the author has dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide][25].  This software is published from the
United States of America and distributed without any warranty.


 [1]: https://www.vim.org
 [2]: https://github.com/vim/vim/commit/c9df1fb35a1866901c32df37dd39c8b39dbdb64a
 [3]: https://github.com/vim/vim/commit/d1068a2bb09fd3b9d117d832105bf10dd5e48e2f
 [4]: https://github.com/vim/vim/commit/a34ba821076476a68e0e579723d68e896f771ba6
 [5]: https://vimhelp.org/starting.txt.html#xdg-base-dir
 [6]: https://www.vidarholen.net/contents/blog/?p=958
   "${var?} and &&: Two simple tips for shell commands in tech docs - Vidar's Blog"
 [7]: https://github.com/git/git/commit/ccdd3da6527ca7d8d731e691b9ff0f9b8657298e
   "clone: Add the --recurse-submodules option as alias for --recursive - git/git@ccdd3da - GitHub"
 [8]: https://github.com/git/git/commit/e7fed18a89fae97655687e19f13cd802d8d70845
   "git clone: Add --recursive to automatically checkout (nested) submodules - git/git@e7fed18 - GitHub"
 [9]: https://github.com/git/git/commit/19a31f9c1a6b18abd8a7f20d616516afca36a6a3
   "git-submodule - Add 'foreach' subcommand - git/git@19a31f9 - GitHub"
[10]: https://github.com/git/git/commit/be4d2c83b68a96285cc05036add4d64d324e52d9
   "submodule update: add convenience option --init - git/git@be4d2c8 - GitHub"
[11]: https://github.com/git/git/commit/70c7ac22de681a83621bda03e676348170c8d8a2
   "Add git-submodule command - git/git@70c7ac2 - GitHub"
[12]: https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives
   "Downloading source code archives - GitHub Docs"
[13]: https://ftp.nluug.nl/pub/vim/patches/7.3/7.3.1178
[14]: https://vimhelp.org/eval.txt.html#no-eval-feature
[15]: https://ftp.nluug.nl/pub/vim/patches/7.0/7.0.234
[16]: https://ftp.nluug.nl/pub/vim/patches/7.0/7.0.235
[17]: https://nvd.nist.gov/vuln/detail/CVE-2007-2438
   "National Vulnerability Database - CVE-2007-2438"
[18]: https://google.github.io/styleguide/vimscriptfull.xml
[19]: https://google.github.io/styleguide/vimscriptfull.xml#Portability
[20]: https://google.github.io/styleguide/vimscriptfull.xml#Variables
[21]: https://google.github.io/styleguide/vimscriptfull.xml#Strings
[22]: https://google.github.io/styleguide/vimscriptfull.xml#Settings
[23]: https://google.github.io/styleguide/vimscriptfull.xml#Functions
[24]: https://vimhelp.org/eval.txt.html#has-patch
[25]: https://creativecommons.org/publicdomain/zero/1.0/
   "Creative Commons - CC0 1.0 Universal Public Domain Dedication"
