OpenFire
========

http://www.igniterealtime.org/projects/openfire/

Start server
------------

Read about OpenFire ports, modify and run command:

    docker run --rm -ti -p 5222:5222 -p 5223:5223 -p 7777:7777 -p 9090:9090 \
        -v ~/openfire:/prj/data/openfire \
        bigm/openfire

Restore embedded DB from other server
-------------------------------------

    mkdir ~/openfire/restore_this
    cp -r from_old_server/openfire/conf ~/openfire/restore_this/
    cp from_old_server/openfire/embedded_db/* ~/openfire/restore_this/     
     
After you restart instance it will copy files to right locations and fix permissions.
The folder _restore_this_ will be renamed to _restore_this_OLD_ and is safe to delete.
