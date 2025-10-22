# kj begin

# configure bash_completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# add gh completions
eval "$(gh completion -s bash)"

# end kj
