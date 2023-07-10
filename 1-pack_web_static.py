#!/usr/bin/python3
"""Deployment scripts"""
from fabric.api import local
from datetime import datetime


def do_pack():
    """Create a .tgz archive from the web_static folder."""
    now = datetime.now()
    timestamp = now.strftime("%Y%m%d%H%M%S")
    archive_path = "versions/web_static_{}.tgz".format(timestamp)

    local("mkdir -p versions")

    result = local("tar -czvf {} web_static".format(archive_path))
    if result.failed:
        return None

    return archive_path
