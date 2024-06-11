{% include alert.html type="informative" icon="info" header="Heads up"
body="When running as a server the program needs elevated privileges. It may be avoided by entering the following command as administrator:" %}
{% include alert.html type="informative" body="
    netsh http add urlacl url=http://*:11000/EPASSaleToPOI/3.1/ sddl=D:(A;;GX;;;WD)" %}
{% include alert.html type="informative" body="
    where :11000 is the default port. If listening to another port the command must be changed." %}
