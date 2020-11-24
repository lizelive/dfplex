FROM ubuntu:20.04

# Pre install
ENV DEBIAN_FRONTEND=noninteractive
# anoyingly enough all these deps are needed for final build
RUN apt-get -y update && apt-get -y install --no-install-recommends build-essential ca-certificates cmake git wget curl libsdl1.2debian libsdl-image1.2 libsdl-ttf2.0-0 libopenal1 libsndfile1 libgtk2.0-0 libncursesw5 libglu1 unzip curl libboost-all-dev bzip2
ENV DEBIAN_FRONTEND=dialog

RUN git clone --recursive https://github.com/white-rabbit-dfplex/dfhack
RUN cd dfhack && ./plugins/dfplex/devel/df-assemble.sh
# doing build here would be ideal to date.

RUN echo "\n[PRINT_MODE:TEXT]\n[INTRO:NO]\n[TRUETYPE:NO]\n[SOUND:NO]" >> /df_linux/data/init/init.txt
RUN echo "\n[BIRTH_CITIZEN:A_D:D_D]\n[MOOD_BUILDING_CLAIMED:A_D:D_D]\n[ARTIFACT_BEGUN:A_D:D_D]" >> /df_linux/data/init/announcements.txt
EXPOSE 8000
EXPOSE 5000
EXPOSE 1234

ENTRYPOINT ["/df_linux/dfhack"]
