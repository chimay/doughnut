<!-- vim: set filetype=markdown: -->

# Work in progress

The core functionality begins to work. A lot of extras has to be done.

# Introduction

Wheel is a plugin for Vim or Neovim aimed at managing buffer groups.

In short, this plugin let you organize your buffers by creating as
many buffer groups as you need, add the buffers you want to it and
quickly navigate between :

- Buffers of the same group
- Buffer groups

Note that :

- A location contains a name, a filename, as well as a line & column number
- A buffer group, in fact a location group, is called a circle
- A set of buffer groups, or a category, is called a torus (a circle of circles)
- The list of toruses is called the wheel

## Goal

Wheel helps you to organize your files in groups that you create yourself,
following your workflow. You only add the files you want, where you
want. For instance, if you have a "organize" group with agenda & todo
files, you can quickly alternate them. Then, if you suddenly got an
idea to tune Vim, you switch to the "vim" group with your favorites
configuration files in it. Same process, to cycle, alternate or display
the files. Note that the toruses containing all these groups can be
saved on a file and loaded later. Over time, your groups will grow and
adapt to your style.

## Why do you need three levels of grouping ?

At first glance, managing groups with circles in a torus seems to
be sufficient. But with time, the torus grows big, and a third level
helps you to organize your files by groups and categories:

  - The wheel contains all the toruses
  - Each torus contains a category of files, e.g.:
    + configuration, development, publication
  - Each circle contains a project, e.g.:
    + emacs or vifm circles in configuration torus
    + shell or elisp in development torus
    + tea or art in publication torus

## History

This project is inspired by :

- [CtrlSpace](https://github.com/vim-ctrlspace/vim-ctrlspace), a similar
plugin for Vim

- [Torus](https://github.com/chimay/torus), a similar plugin for Emacs,
itself inspired by MTorus

# Step by Step

In the following discussion, I assume that you have kept the default
mapping prefix :

```
g:wheel_config = '<d-w>'
```

## Mnemonic

Most mappings respect the following convention :

- prefix + `letter`     : location operation
- prefix + `<C-letter>` : circle operation
- prefix + `<S-letter>` : location operation

## First Circles

Let’s say we have the files `Juice`, `Tea`, `Coffee` and we want to
group them. So, we go `Juice` and type `<D-w>a` to add a location to the
wheel. If no torus is present in the wheel, it will create it and ask
for a name. Let’s say we name it `Food`. If no group (no circle) is
found in the torus, it will be created and prompt for a name. Let’s say
we choose `Drinks`. Finally, our file `Juice` is added to the group. Its
name is the filename without extension by default.

Then, we go to `Tea` and type `<D-w>a` again. This time, it will just
ask us if we want to keep the default location name. Press enter, and
`Tea` is added to the `Drinks` group.

Same process with `Coffee`. We now have a circle `Drink` containing
three files.

If you want to create another circle, let’s say `Fruits`, simply launch
`<D-w><C-a>`, and answer `Fruits` to the prompt. You can then add the
files `Apple`, `Pear` and `Orange` to it. You can even also add `Juice`:
a file can be added to more than one circle.

Now, suppose that in the `Juice` file, you have a Pineapple
and a Mango sections, and you want to compare them. Just go to
the Pineapple section, and use `<D-w>a`. It will add the location
`Juice:pineapple-line:pineapple-col` to the current circle. Then, go to
the Mango section, and do the same. The `Juice:mango-line:mango-col`
will also be added to the circle. You can then easily alternate both,
or display them in split windows.

If you want to create another torus, let’s say `Books`, simply launch
`<D-w><S-a>`, and answer `Books` to the prompt.

## Moving around

### Cycling

You can cycle the files of a circle with `<D-w><Left>` and
`<D-w><Right>`. These are often used bindings, so I suggest you map them
to a more convient key, like `<C-PageUp>` and `<C-PageDown>`

To cycle the circles, use `<D-w><C-left>` and `<D-w><C-right>`. These are
often used bindings, so I suggest you map them to a more convient key,
like `<C-Home>` and `<C-End>`

To cycle the toruses, use `<D-w><S-left>` and `<D-w><S-right>`. These are
often used bindings, so I suggest you map them to a more convient key,
like `<S-Home>` and `<S-End>`

### Switch using completion

You can also switch location by completion with `<D-w><CR>`.

You can also switch circle by completion with `<D-w><C-CR>`.

You can also switch torus by completion with `<D-w><S-CR>`.

### Switch using a special buffer

You can also switch location by chosing it in a special buffer. The
default mapping is `<D-w><Space>`. Pressing enter on a line will switch
to the matching location. Going to insert mode will allow you to filter
the lines with one or more words.

To choose a given circle in a special buffer, use `<D-w><C-space>`.

To choose a given torus in a special buffer, use `<D-w><S-space>`.

## Square the Circle

Over time, the number of circles will grow. Completion is great, but
if you just want to alternate the two last circles in history, you’ll
probably prefer `<D-w>^`.

You can also alternate two last files inside the same circle with
`TODO`. So, you have the square :

| circle 1, file 1 | circle 1, file 2 |
| circle 2, file 3 | circle 2, file 4 |

at your fingertips.

Finally, `TODO` alternate two last history
files, regardless of their circles.


## Splits

If you prefix a torus navigation function by C-u, the asked file will
be opened in a new window below. With C-u C-u, it will be in a new
window on the right.

If you want to see all the circle files in separate windows, use
`TODO` and chose between horizontal, vertical or grid
splits. You also have layouts with main window on left, right, top or
bottom side.

Your choice is remembered by torus for the current circle. You can
swith back to one window using the same layout function. The special
choice "manual" ask Torus not to interfere in your layout.

The maximum number of windows generated by the split functions
are conxtrolled by the vars `TODO` and
`TODO`.

# Licence

MIT
