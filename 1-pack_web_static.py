#!/usr/bin/python3
from fabric.api import *
from datetime import datetime
import tarfile

# env.hosts = [
#     '35.153.93.137',
#     '54.236.33.80'
#   # 'server2.domain.tld',
# ]
# # Set the username
# env.user   = "ubuntu"


def do_pack():
    source = "web_static"
    now = datetime.now()
    of = f"versions/web_static_{now.strftime('%Y%m%d%H%M%S')}.tgz"
    local("mkdir -p versions")
    result = local(f"tar -czvf {of} web_static")
    if result.failed:
        return None
    return of
