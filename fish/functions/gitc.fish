function gitc --wraps='git commit -m' --description 'alias gitc git commit -m'
  git commit -m $argv
        
end
