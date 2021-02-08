#!/usr/bin/env python3
# encoding: utf-8

"""
This module contains all debug related functionality.
"""

from . import fold

import vim


def debug(sorting_line_number=1):
    """
    Print debug information about how folds are extracted and sorted.

    Useful for debugging.
    """
    print("###############")
    print("#  Extracted  #")
    print("###############")

    print_folds(fold.get_folds())

    print("############")
    print("#  Sorted  #")
    print("############")

    sorted_folds = sorted(fold.get_folds(),
                          key=fold.get_fold_to_sort_key(sorting_line_number))
    print_folds(sorted_folds)


def print_foldlevel():
    """
    Print foldlevel of all lines in current range.
    """
    cr = vim.current.range
    for lvl, line in zip(fold.line_range_to_foldlevel(cr.start, cr.end), cr[:]):
        print(lvl, line)


def print_folds(folds):
    """
        Prints all supplied folds for debug purposes.
    """
    for fold in folds:
        print("---")
        for line in fold.lines:
            print(fold.level, line)
