# Prevent virtualenv from prepending the name of the environment
activate() {
  export VIRTUAL_ENV_DISABLE_PROMPT='1'
  source ./$1/bin/activate
}