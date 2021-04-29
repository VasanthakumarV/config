# Defined in - @ line 1
function tmux --wraps='tmux -u' --description 'alias tmux=tmux -u'
 command tmux -u $argv;
end
