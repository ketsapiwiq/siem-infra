
import urllib2
from urlparse import urlparse
# We'll use ElementTree to parse the XML as it's a simple binding which ships with Python
import xml.etree.ElementTree as ET
# These are used to help with HTTP basic auth and generate random message IDs, respectively
import base64
import random

# The namespace of the TAXII document we'll send to the server
taxii_ns = 'http://taxii.mitre.org/messages/taxii_xml_binding-1.1'

# This class parses the CybOX results from the server
class CybOXObject(object):

    # xml parameter should be an ElementTree.Element with the CybOX object inside it
    # url parameter is the feed location
    def __init__(self, xml, baseurl):
        # construct a new URL we can use to browse to this object in the Soltra dashboard
        p = urlparse(baseurl)
        self.url = '%s://%s/object/%s' % (p.scheme, p.netloc,  xml.get('id'))
        # Find all file hashes using the ElementTree "findall" method. Each
        # Simple_Hash_Value XML node can contain multiple hashes separated by a delimiter.
        self.hashes = []
        for hashval in xml.findall('.//{http://cybox.mitre.org/common-2}Simple_Hash_Value'):
            self.hashes.extend(hashval.text.split(hashval.get('delimiter', '##comma##')))

# Internal function constructing an HTTP request to read unread threat data via TAXII
def _taxii_req(url, feedname, username, password):
    # Construct an XML document with 'Poll_Request' as the top-level node name.
    xmldata = ET.Element('Poll_Request', {'xmlns': taxii_ns,
                                          'message_id': str(random.randint(345271,9999999999)),
                                          'collection_name': feedname})

    # Fill in a few TAXII parameters
    pp = ET.SubElement(xmldata, 'Poll_Parameters', {'allow_asynch': 'false'})

    ET.SubElement(pp, 'Response_Type').text = 'FULL'
    ET.SubElement(pp, 'Content_Binding', {'binding_id': 'urn:stix.mitre.org:xml:1.1.1'})

    # Create an HTTP request with our XML as the POST data
    req = urllib2.Request(url, ET.tostring(xmldata))

    # Add some headers to the request and return it
    if username is not None and password is not None:
        req.add_header('Authorization', 'Basic %s' % 
                       base64.encodestring('%s:%s' % 
                       (username, password)).replace('\n', ''))
    req.add_header('Content-Type', 'application/xml')
    req.add_header('User-Agent', 'TAXII Client Application')
    req.add_header('Accept', 'application/xml')
    req.add_header('X-TAXII-Accept', 'urn:taxii.mitre.org:message:xml:1.1')
    req.add_header('X-TAXII-Content-Type', 'urn:taxii.mitre.org:message:xml:1.1')
    req.add_header('X-TAXII-Protocol', 'urn:taxii.mitre.org:protocol:https:1.0')
    return req

# Function to poll a TAXII feed. Returns a list of CybOXObject instances
def poll_feed(url, feedname, username, password):
    return [CybOXObject(x, url) for x in
            ET.fromstring(urllib2.urlopen(_taxii_req(url, feedname, username, password)).read())
            .findall('.//{http://cybox.mitre.org/cybox-2}Object')]

# Example command-line usage
if __name__ == '__main__':
    import sys
    if len(sys.argv) < 3:         print "usage: taxii.py url feedname [username] [password]"         sys.exit(-1)     url = sys.argv[1]     feedname = sys.argv[2]     username, password = None, None     if len(sys.argv) >= 5:
        username = sys.argv[3]
        password = sys.argv[4]

    for obj in poll_feed(url, feedname, username, password):
        if obj.hashes:
            print "%s: %s" % (obj.url, obj.hashes)

