if [[ -d .git && $AUTO_UPDATE == "1" ]]; then
    git pull
fi

if [[ ! -z $PY_PACKAGES ]]; then
    pip install -U --prefix .local $PY_PACKAGES
fi

if [[ -f /home/container/$REQUIREMENTS_FILE ]]; then
    pip install -U --prefix .local -r $REQUIREMENTS_FILE
fi

/usr/local/bin/python /home/container/$PY_FILE
