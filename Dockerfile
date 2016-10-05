FROM centos:7

MAINTAINER Cisco DevOps <hyungsok@cisco.com>

RUN yum install git python-devel python-pip -y
RUN curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python /tmp/get-pip.py
RUN pip install pyvmomi django requests tabulate 

RUN git clone https://bitbucket.org/Neocyon/cloudportal /opt/cloudportal
RUN python /opt/cloudportal/manage.py makemigrations
RUN python /opt/cloudportal/manage.py migrate
RUN echo "from django.contrib.auth.models import User; User.objects.create_superuser('cisco', 'hyungsok@cisco.com', 'C1sco123!')" | python /opt/cloudportal/manage.py shell

# Start Services
EXPOSE 8080

CMD python /opt/cloudportal/manage.py runserver 0.0.0.0:8080
