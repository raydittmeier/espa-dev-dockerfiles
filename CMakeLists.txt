set ( TAG_PREFIX dev )
set ( ESPA_VERSION 2.13.0 )

add_custom_target (
    tools
    COMMAND docker build -t ${TAG_PREFIX}/tools -f centos/tools/Dockerfile .
    COMMAND docker tag ${TAG_PREFIX}/tools ${TAG_PREFIX}/tools:${ESPA_VERSION}
)

add_custom_target (
    espa
    COMMAND docker build -t ${TAG_PREFIX}/espa -f centos/espa/Dockerfile .
    COMMAND docker tag ${TAG_PREFIX}/espa ${TAG_PREFIX}/espa:${ESPA_VERSION}
    DEPENDS tools
)
