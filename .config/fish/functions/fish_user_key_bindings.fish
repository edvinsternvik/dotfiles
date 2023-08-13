function fish_user_key_bindings
    fish_vi_key_bindings

    bind -M insert \cf forward-word
    bind \cf forward-word

    bind -M insert \cn forward-bigword
    bind \cn forward-bigword
end
