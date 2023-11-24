#--- Release ---
FROM spaceskynet/bitnsc-ctfd:latest

ARG WORKDIR
ENV WORKDIR_IN ${WORKDIR}
WORKDIR $WORKDIR
RUN mkdir -p $WORKDIR /var/log/CTFd /var/uploads
COPY . $WORKDIR

RUN pip install -i https://mirrors.cloud.tencent.com/pypi/simple/ --no-cache-dir -r requirements.txt \
    && for d in CTFd/plugins/*; do \
        if [ -f "$d/requirements.txt" ]; then \
            pip install -i https://mirors.cloud.tencent.com/pypi/simple/ --no-cache-dir -r "$d/requirements.txt";\
        fi; \
    done;

RUN python -m ensurepip --upgrade

RUN chmod a+x $WORKDIR/docker-entrypoint.sh

EXPOSE 8000
ENTRYPOINT ${WORKDIR_IN}/docker-entrypoint.sh
