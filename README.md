## Highlite Spb

[Highlite Spb](http://highlite-spb.ru) is a show equipment store. It is a eCommerce project, consisting of following parts:
- [highlite2-sylius](https://github.com/oliosinter/highlite2-sylius) - online store, based on [Sylius](https://sylius.com) eCommerce framework;
- [highlite2-import](https://github.com/oliosinter/highlite2-import) - product import tool, written in Golang;
- [highlite2-jenkins](https://github.com/oliosinter/highlite2-jenkins) - continuous delivery.

## Highlite2 Jenkins

Highlite Spb uses Jenkins for Continuous Delivery. Jenkins runs in a docker container using
[dockerfile-jenkins](https://github.com/oliosinter/dockerfile-jenkins) as a base image.

## Usage
- `make run` start jenkins;
- `make stop` stops jenkins (stops the container but does not remove it);
- `make clean` removes jenkins container;
- `make admin-password` shows initial admin password.

Highlite2-jenkins uses external volume `highlite2-jenkins-home` binded to `/var/jenkins_home` directory 
in the container. This volume is not removed with `make clean` cmd. It means that your settings will 
still remain even if you remove the container and start it again. If you want to delete that volume you can 
do it manually using `docker volume rm highlite2-jenkins-home` cmd.

Before starting Jenkins you must create **config.yml** file with settings. Refer to [_config.env](_config.env) for
config template. If you are using `make run` cmd it will not start if there is no **config.yml** and will ask you to
create it.   

## Pipeline scripts

### sylius-release
You can set up integration with github to start this script automatically when there was push to the repository.
- **Type**: Pipeline Script from SCM
- **Repository Url**: https://github.com/oliosinter/highlite2-sylius.git
- **Script Path**: `ci/release/Jenkinsfile`

This build is parametrized and requires following options:
- **DOCKER_USER** is used for pushing release images;
- **DOCKER_PASSWORD** is used for pushing release images;

### sylius-deploy
You can set up this script to start automatically anytime when **sylius-release** script is finished.
- **Type**: Pipeline Script from SCM
- **Repository Url**: https://github.com/oliosinter/highlite2-sylius.git
- **Script Path**: `ci/prod/Jenkinsfile`

This build is parametrized and requires following options:
- **VERSION** is a release image tag;
- **ENV** is an environment variable (prod, staging, dev);




