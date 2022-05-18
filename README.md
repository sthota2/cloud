# Cloud
All Cloud Provider Specific Infrastructure as Code (IAC) goes in here
* aws
* azure
* gcp
* oci

## Syntax
Synatax is as follows 
```
<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
```
Example: 
```
PROVIDER:aws
TYPE:security_group
NAME:instance (Name of the resource)
ATTRIBUTE: Name or one of the attributes exported by the resource.
```

