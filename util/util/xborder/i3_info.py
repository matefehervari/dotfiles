#!/bin/python3

from time import sleep
from typing import List

import i3ipc
from pipe import select, where

from util import Get, Is, NoneGet, first, tolist, toset

i3 = i3ipc.Connection()


def viewable(con) -> bool:
    return con.window and con.parent.type != "dockarea"


def get_active_window() -> int | None:
    return i3.get_tree() | where(Get.focused) | first | NoneGet.pipe.window


def get_floating_window_ids() -> set[int]:
    return i3.get_tree() | where(Get.floating | Is.equal_to("user_on")) | select(Get.window) | toset


def get_ordered_window_ids() -> List[int]:
    return i3.get_tree() | where(viewable) | select(Get.window) | tolist


if __name__ == "__main__":
    report_count = 1
    while True:
        print(f"Report {report_count}\n")
        for con in i3.get_tree():
            if con.window and con.parent.type != "dockarea":
                print(
                    f"id = {con.window} "
                    + f"name = {con.name} "
                    + f"workspace = {con.workspace().name} "
                    + f"num = {con.layout} "
                    + f"focused = {con.focused}"
                )
        print(get_floating_window_ids())
        print()
        sleep(1)
        report_count += 1
