#sphinxsearch

##Start

Create `/confs/sphinxsearch/myproject/mysphinx.conf` with your source and index definitions.

    docker run --name sphinxsearch \
        -e SPHINXSEARCH_CONFIG_D=/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/myproject:/data/prj/sphinxsearch \
        quay.io/bigm/sphinxsearch

If you want to use tune idexer, searchd and common settings mount also `/confs/sphinxsearch/main.conf` and start with:

    docker run --name sphinxsearch \
        -e SPHINXSEARCH_CONFIG_D=/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/myproject:/data/prj/sphinxsearch \
        -v /confs/sphinxsearch/main.conf:/etc/sphinxsearch/main.conf \
        quay.io/bigm/sphinxsearch
