# About
This repo is a kde plasma widget that can control google assistant with a click of a button.

# google
The only thing missing from this is how to setup google assistant python service.
However once you have done that then you will need to edit the python package:

In the file:
"~/.local/lib/python3.10/site-packages/google/assistant/library/__main__.py"
We need to add the line:
```
quit()
```
at around line 64
```
    if (event.type == EventType.ON_CONVERSATION_TURN_FINISHED and
            event.args and not event.args['with_follow_on_turn']):
        print()
        quit()
    if event.type == EventType.ON_DEVICE_ACTION:
```
like this.

This is so the assistant quits after it has finished with your query.
Its ugly but it works.

# Setup
The "org.kde.plasma.MYGAcontrol" folder should be placed in ~/.local/share/plasma/plasmoids/

This is configued to use distrobox by default. The commands are all listed in org.kde.plasma.MYGAcontrol/content/config/main.xml, You can change these to what ever you need, right now they are set to calling my "assistant" script from within distrobox. 

The assistant script is this (w/ redacted info)
```
#!/bin/bash
source env/bin/activate
query=$@
google-assistant-demo --project-id xxxxxx --device-model-id xxxxxx --credentials credentials.json --query "$query" &>/dev/null
```
we need the source line because thats the python enviroment within distrobox


