aaxtomp3-docker

A docker container to ease running AAXToMp3 

```bash
docker run --rm -it \
  -v "$PWD":/working \
  -e AAX_ACTIVATION_CODE=xxxxxxxx \
  aax-to-mp3 \
    run-aax FILE.aax
```
