#!/usr/bin/env python
import xmpp, os, sys

if len(sys.argv) < 3:
    print "Syntax:", sys.argv[0], " "
    sys.exit(1)

jid = xmpp.protocol.JID(os.environ["XMPP_USER"])
cl = xmpp.Client(jid.getDomain(), debug = [])
con = cl.connect()
cl.auth(jid.getNode(), os.environ["XMPP_PASSWORD"])
cl.sendInitPresence()

msg = xmpp.Message(sys.argv[1], sys.argv[2])
msg.setAttr('type', 'chat')
cl.send(msg)
