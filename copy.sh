#!/bin/bash
copy () {
  /bin/cat $1 | xclip -selection clipboard
}
