resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

name 'Dog Emote Menu'
description 'Emote menu for dogs'

client_scripts {
    'client.lua',
    '@NativeUI/NativeUI.lua',
    'menu.lua'
}
server_script("server.lua")
