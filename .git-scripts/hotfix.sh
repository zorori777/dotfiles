NEXT_VERSION=$1
CURRENT_BRANCH=`git symbolic-ref --short HEAD`
GIT_DIFF=`git diff --name-only`
QUIT='Quit'
YOURSELF="Yourself"


# 事前処理
if test "$GIT_DIFF" != ''; then
  git add .
  git stash --quiet
fi

git checkout master --quiet
git pull --quiet
CURRENT_VERSION=`git describe`

VERSIONS=( ${CURRENT_VERSION//[.|-]/ } )
echo Current version info is as follows.
echo Major: ${VERSIONS[0]}
echo Minor: ${VERSIONS[1]}
echo Patch: ${VERSIONS[2]}
echo ''

PATCH_UPDATE=$((VERSIONS[0])).$((VERSIONS[1])).$((VERSIONS[2]+1))

PS3='Please select next version:'
options=($PATCH_UPDATE $YOURSELF $QUIT)
if [ -z "$NEXT_VERSION" ]; then
  select res in "${options[@]}"
  do
    if [ $res = $QUIT ]; then
      git checkout $CURRENT_BRANCH
      git stash pop --quiet
      exit 0
    elif [ $PATCH_UPDATE = $res ]; then
      NEXT_VERSION=$res
      break
    elif [ $YOURSELF = $res ]; then
      echo 'What is next version?'
      read NEXT_VERSION
      break
    fi
  done
fi


# 本処理
git checkout master --quiet
git pull --quiet
git checkout -b hotfix/$NEXT_VERSION --quiet


# 事後処理
if test "$GIT_DIFF" != ''; then
  git stash pop --quiet
fi
