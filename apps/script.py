#!/usr/bin/env python3

import datetime
import logging
import os
import socket

logger = logging.getLogger("my_logger")
logger.setLevel(logging.INFO)

file_handler = logging.FileHandler("my_log_file.log")
console_handler = logging.StreamHandler()

file_handler.setLevel(logging.DEBUG)
console_handler.setLevel(logging.INFO)

formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)


def main() -> None:
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    logger.info("START script")

    hostinfo = os.uname()
    logger.info(f"hostinfo: {hostinfo}")

    current_time = datetime.datetime.now()
    logger.info(f"Aktualny czas: {current_time}")

    hostname = socket.gethostname()
    logger.info(f"hostname: {hostname}")

    logger.info("END script")


if __name__ == "__main__":
    main()
