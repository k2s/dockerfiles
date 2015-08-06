#sphinxsearch

##Start

Create `/confs/sphinxsearch/myproject/mysphinx.conf` with your source and index definitions.

    docker run --name sphinxsearch \
        -e SPHINXSEARCH_CONFIG_D=/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/myproject:/data/prj/sphinxsearch \
        quay.io/bigm/sphinxsearch
                        
It is possible to use mount project specifics configuration sources to different folders: 

    docker run --name sphinxsearch \
        -e SPHINXSEARCH_CONFIG_D="/data/prj/sphinxsearch/myprojectA /data/prj/sphinxsearch/myprojectB" \
        -v /confs/sphinxsearch/myprojectA:/data/prj/sphinxsearch/myprojectA \
        -v /confs/sphinxsearch/myprojectB:/data/prj/sphinxsearch/myprojectB \        
        quay.io/bigm/sphinxsearch

If you want to use tune idexer, searchd and common settings mount also `/confs/sphinxsearch/main.conf` and start with:

    docker run --name sphinxsearch \
        -e SPHINXSEARCH_CONFIG_D=/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/myproject:/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/main.conf:/etc/sphinxsearch/main.conf \
        quay.io/bigm/sphinxsearch

##Environment variables

* SPHINXSEARCH_CONFIG_MAIN: location of main configuration file (idexer, searchd and common settings)
* SPHINXSEARCH_CONFIG_D: space separated list of project specifics index/source configurations 
* SPHINXSEARCH_STARTUP_INDEXER: if not empty it will be added to indexer command on instance start
* SPH_API_KEY: if provided it will start Spinx Tools Agent, see https://tools.sphinxsearch.com/node/list


##TODO 

* was not able to see sphinxagent reporting data to https://tools.sphinxsearch.com/node/list