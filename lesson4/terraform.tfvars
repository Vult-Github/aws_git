#provider
region               = "us-east-1"
profile              = "lessonvult"
environment_type     = "Test"
projectname          = "Lesson"
ec2_instance_type    = "t2.micro"
lesson_number        = "3"
vpc_cidr             = "172.22.0.0/16"
subnetA_cidr         = "172.22.12.0/26"
subnetB_cidr         = "172.22.22.0/26"
subnetA_availib_zone = "us-east-1a"
subnetB_availib_zone = "us-east-1b"
private_key_pem      = <<VULT
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDOWBH6ybyyEdJl
M2sjStONaD/+UMMQxNOnVP8qSEd4IuodXOEoZQN+h/BiwAmFD2Thue1X1QosxkzX
KfkDQh/oEZ29Ih0xfYkyB+sPCunChK5GHjVoGd5EIVVWGHqCZ6qVMX1QWuzDpvH3
s3emBWfj9fHv/Bvg0efDyFMrdzcPmf5IBTTh8J542pit0WKCLCjYKcvaH/6KPpLy
p/XD/rIYVnCdgsNZXBwMC1urp6AkzWanu5BS5ac6atIsD1rpVLhAuU2tj0tcQ/iA
4RA2if48YdP/rzJo/UDxsovLP2bnVk2t/HUlEkZRhAbPLhSMLprH0V5Ns5AkcGfF
A3OIJ7DxAgMBAAECggEAag0juISE4fR88Rx7PRlRH4VsFnZFu1GeAouR1ZZufRVc
xBifdFZudFLDvs06V1PxIn6fuJu67gZBKfjdjcongevD6Zgl7vC5WahuLD4MpLfy
pgESq91XuiZzqJtOI8XKC4HzCSCiPXCJPijUHtT6b1RRs2kcnvDjMGG+NUHBX9d1
Zj61m2/gGuaoZ4gy+q7SNQ5BUjltcMWP7TWHah75XXLC+0yC88h2iBcrrLkKZGZS
GhNMxrQxSVLx301TxTeSlM1b+LMyT5D1roOzzFysjcnROhfwoCvxf7QL0LvbP0WT
UsRTrtXm02m2B2K/EwuIrxGtvi1twkhfymUuRmvL7QKBgQD8lEWcyMAx71XRjcaE
nXcyIN8PgQoTIyrxsBaJzG6LwwOKH4uaCWySp0YXapwtGmQTiF+5pWHa5t5Q6Deg
0Asj/xUCWDve+OZkFam8OtDD+l2OPSuamGHN6mfcVYW61hlxMmXb0vgO/b46k3b9
pRG/EtrZJHyFObWjXoJg0YUzrwKBgQDRI36RO/be3qqUSwhY4cRgv5Kdwsbk+pkT
62OzjJBAoIUcsl2YkBQuzUD4bz+7FI9aR2i8xLf9QrZlam2BRmZokyXGNNsx0IyM
LS/3919iqExgTPeJjlA1iZBaaClKNnzvRJ4/vCzLNA9rFAc9CuPjfhn4IaTSTAzP
w7q3UMhtXwKBgAtjeBwQpTHbM8hmFxxlqTk2aDhfvh+Mx2PsZ6fA8v8URPWWZIoG
gMHADxYBNZeHCBolXQOW5GmlXULSpad3mfj+iGj5p4FvQZwjqeqV0FH12QAP3AZ1
dnt9ZT93D7eT7cO/3P3jblHmuQwVGBlptvohlIKT9ZVgO8NpAIHzEIl7AoGAVjzc
o+amFaCbliqadowh/gMA4iy+9wyesqgNpKwBj6ShPwQNtCs1J1dbwxWcofgIZKGt
fqlfdP9dVtRb80KkV9rVaLXC7Peh/OtlLErE+lmLpOoX6JDWYj0nWSA6Zm+xdLhG
yOE/V0tQUEch9PnYnqYQ71BwNodFgSakh5K4EuECgYBfyFf58BeVSjYFTPFK9s6F
1Mrl7FAdXlx+QXCGk3eFJTF2tltV+ylyFsoFCS3rRN4eD4qPi5jmwaprxwlpfdil
+xRF2JecMMIFnqksmji/qAwQeVVKDwzNMTrNTprrvYxLbB9IC+Hj6thBIkBRRa0N
B0NyJug6+VA3LfQCswd7HQ==
-----END PRIVATE KEY-----
VULT
cert_pem             = <<VULT
-----BEGIN CERTIFICATE-----
MIIDyTCCArGgAwIBAgIUA23ANGwzq18Bu6LGarTV+PnJMf8wDQYJKoZIhvcNAQEL
BQAwdDELMAkGA1UEBhMCQlkxDDAKBgNVBAgMA0JZTjEOMAwGA1UEBwwFTWluc2sx
DTALBgNVBAoMBEhlbGwxEDAOBgNVBAsMB0RldkhlbGwxJjAkBgNVBAMMHSoudXMt
ZWFzdC0xLmVsYi5hbWF6b25hd3MuY29tMB4XDTIyMDkxOTEzMDc0MFoXDTIzMDkx
OTEzMDc0MFowdDELMAkGA1UEBhMCQlkxDDAKBgNVBAgMA0JZTjEOMAwGA1UEBwwF
TWluc2sxDTALBgNVBAoMBEhlbGwxEDAOBgNVBAsMB0RldkhlbGwxJjAkBgNVBAMM
HSoudXMtZWFzdC0xLmVsYi5hbWF6b25hd3MuY29tMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAzlgR+sm8shHSZTNrI0rTjWg//lDDEMTTp1T/KkhHeCLq
HVzhKGUDfofwYsAJhQ9k4bntV9UKLMZM1yn5A0If6BGdvSIdMX2JMgfrDwrpwoSu
Rh41aBneRCFVVhh6gmeqlTF9UFrsw6bx97N3pgVn4/Xx7/wb4NHnw8hTK3c3D5n+
SAU04fCeeNqYrdFigiwo2CnL2h/+ij6S8qf1w/6yGFZwnYLDWVwcDAtbq6egJM1m
p7uQUuWnOmrSLA9a6VS4QLlNrY9LXEP4gOEQNon+PGHT/68yaP1A8bKLyz9m51ZN
rfx1JRJGUYQGzy4UjC6ax9FeTbOQJHBnxQNziCew8QIDAQABo1MwUTAdBgNVHQ4E
FgQUGe/vDbG6bdC9THGtnNIAV7StW94wHwYDVR0jBBgwFoAUGe/vDbG6bdC9THGt
nNIAV7StW94wDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAX4PR
TbsGUUyGPT2MtVJETfh4oBUT61On1NdHee8AKSn6+Cwm9Y9JAYFZCjLutCaYIopg
XrqMri6z3GtU2HOhlYWqKTLMchcBzO+D3nXapPDyjZwz7taLF+XH/ojdv/xC5AKS
g3Qkwm8RGWTSHGvjKZA++xm7ofW6XP2AhpgztqtvmlAbUhyrBbi+n4HO19ZFl6HZ
dYTqjvAB1kb+fE7/qxusPYlR+rYQytcHUUl4SFeIqWI18WMzygPCgWNcHjTXPM8D
qdKzotwb2RAWCojkudjHfzS0u5F2S7gU6rnbmKj5Pm/E9Sm9ymPIoYTGbGjXxET1
Kln67SHtHnojtF8Trg==
-----END CERTIFICATE-----
VULT
