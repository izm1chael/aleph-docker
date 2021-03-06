DEBUG = True

SAMPLE_SOURCES = [
    ('local', {'path': '/opt/aleph/unprocessed_samples'}),
    #('mail', {'host': 'imap.exampl.com', 'username': 'youruser@example.com', 'password': 'yourpassword', 'root_folder': 'Inbox' })
]

PLUGIN_SETTINGS = {
    #'virustotal': { 'enabled': True, 'api_key': '', 'api_limit': '7' }
}

ELASTICSEARCH_URI = '127.0.0.1:9200'
ELASTICSEARCH_INDEX = 'samples'
ELASTICSEARCH_TRACE = False

SAMPLE_TEMP_DIR = '/opt/aleph/temp'
SAMPLE_STORAGE_DIR = '/opt/aleph/samples'

SAMPLE_MANAGERS=2 # Simultaneous sample analysis

SAMPLE_MIN_FILESIZE=40 # bytes
SAMPLE_MAX_FILESIZE=(1024*1024*30) # bytes

SECRET_KEY = 'Pu7s0m3cryp7l337here' #do not use this ;)
SAMPLE_SUBMIT_FOLDER= '/opt/aleph/samples' #where samples will be submitted from webui

# Mail Options
MAIL_ENABLE = False
MAIL_SERVER = 'smtp.googlemail.com'
MAIL_PORT = 587
MAIL_USE_TLS = True
MAIL_USE_SSL = False
MAIL_USERNAME = 'your-gmail-username'
MAIL_PASSWORD = 'your-gmail-password'
MAIL_SENDER = 'Your Name <%s>' % MAIL_USERNAME

# WebUI Options
import os
SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.path.abspath(os.path.dirname(__file__)), '../webui/db.sqlite' )
del os
SERVER_NAME = 'localhost:5000'
PREFERRED_URL_SCHEME = 'http'
ALLOW_REGISTRATIONS = True
SAMPLE_SUBMIT_FOLDER = None

LOGGING  = {
	'directory': 'log/',
    'filename': 'aleph.log',
    'format': '%(asctime)s [%(name)s:%(funcName)s] %(levelname)s: %(message)s',
}