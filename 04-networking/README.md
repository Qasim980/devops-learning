# 04 - Networking

Understanding networking is crucial for debugging, security, and infrastructure design.

## What You'll Learn

- OSI model and TCP/IP
- IP addressing and subnets (CIDR)
- DNS and how domain resolution works
- HTTP/HTTPS and TLS
- Load balancers and reverse proxies
- Firewalls and security groups
- Common ports and protocols

## Folder Structure

```
04-networking/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Set up a local DNS server
- [ ] Configure nginx as a reverse proxy
- [ ] Create a subnet calculator script
- [ ] Analyse traffic with tcpdump/Wireshark

## Key Concepts

| Port | Protocol | Use |
|------|----------|-----|
| 22 | SSH | Secure shell |
| 80 | HTTP | Web traffic |
| 443 | HTTPS | Secure web traffic |
| 53 | DNS | Domain resolution |
| 3306 | MySQL | Database |
| 5432 | PostgreSQL | Database |
| 6379 | Redis | Cache |

## Useful Commands

```bash
ping <host>           # Test connectivity
curl -v <url>         # HTTP request with details
dig <domain>          # DNS lookup
nslookup <domain>     # DNS lookup
netstat -tuln         # Show listening ports
ss -tuln              # Show listening ports (modern)
traceroute <host>     # Trace network path
```

## Resources

- [Subnet Calculator](https://www.subnet-calculator.com/)
- [DNS Explained](https://howdns.works/)
