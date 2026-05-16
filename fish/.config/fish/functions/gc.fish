function gc --wraps='git clone --depth 1' --description 'alias gc=git clone --depth 1'
    git clone --depth 1 $argv
end
