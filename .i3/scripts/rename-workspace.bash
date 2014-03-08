#!/bin/bash

read old_workspace
read new_workspace

i3-msg rename workspace $old_workspace to $new_workspace
