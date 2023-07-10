#!/usr/bin/python3
"""Deployment scripts"""
from fabric.api import local
from datetime import datetime
import os


def do_pack():
    """Create a .tgz archive from the web_static folder."""
    now = datetime.now()
    timestamp = now.strftime("%Y%m%d%H%M%S")
    archive_path = "versions/web_static_{}.tgz".format(timestamp)
    if not os.path.isdir("versions"):
        os.makedirs("versions")

    result = local("tar -cvzf {} web_static".format(archive_path))
    if result.failed:
        return None

    return archive_path
