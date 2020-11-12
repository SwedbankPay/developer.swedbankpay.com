{% include alert.html type="warning" icon="warning" header="GDPR" body="GDPR
sensitive data such as email, phone numbers and social security numbers must
**not be used directly** in request fields such as `payerReference`. If it is
necessary to use GDPR sensitive data, it must be hashed and then the hash can be
used in requests towards Swedbank Pay." %}
