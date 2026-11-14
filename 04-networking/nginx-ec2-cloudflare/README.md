# EC2 + NGINX + Cloudflare Domain Setup

## 🔧 What I Did

* Bought domain `qasimsabir.co.uk` from Cloudflare Registrar
* Launched a free-tier EC2 instance (Ubuntu Server 24.04, t3.micro, eu-west-2)
* Configured the security group: HTTP (port 80) open to the world, SSH (port 22) restricted to my own IPv4 address
* Installed NGINX using `install_nginx.sh` and enabled it to start on boot
* Pointed `qasimsabir.co.uk` to the EC2 public IPv4 address via an A record in Cloudflare (DNS only, proxy off)
* Added a `www` CNAME pointing to the root domain
* Verified the setup using `systemctl status`, `dig`, and the browser

## 🌐 Live Example

http://qasimsabir.co.uk

(HTTP only. HTTPS is not configured. The instance may be stopped after the assignment, so the link may not stay live.)

## 🖥️ Technologies Used

* AWS EC2
* NGINX
* Cloudflare (Registrar + DNS)
* Ubuntu Linux

## 🧠 Skills Practiced

* Linux server setup
* Web server hosting
* DNS management (A and CNAME records)
* Security group configuration
* Debugging connectivity and DNS issues

## 🛠️ Setup Steps

1. Buy the domain in Cloudflare
2. Launch the EC2 instance with a public IPv4 address and a key pair
3. Allow SSH (my IP only) and HTTP (anywhere) in the security group
4. SSH in and run the install script:
   ```bash
   bash install_nginx.sh
   ```
5. Confirm NGINX works by visiting `http://<ec2-public-ip>`
6. Create an A record (`@` → EC2 public IPv4) in Cloudflare, set to DNS only
7. Check DNS with `dig qasimsabir.co.uk +short`, then visit `http://qasimsabir.co.uk`

## 🐛 Issues I Hit and How I Fixed Them

* **SSH timed out:** the security group rule created by "My IP" used my IPv6 range, but I was connecting over IPv4. Fixed by replacing the source with my IPv4 address as a `/32` (found with `curl -4 ifconfig.me`).
* Ubuntu uses `apt`, so I used `apt install nginx`.
* **Site can't be reached on the bare IP:** browsers try HTTPS (port 443) first, which isn't open or configured. Using `http://` explicitly fixes it.

## 📸 Screenshots

See the `screenshots/` folder for the security group rules, NGINX service status, Cloudflare DNS records, `dig` output, and the NGINX welcome page on the domain.

## 🚀 Next Steps

* Add HTTPS with Certbot (Let's Encrypt) and open port 443
* Attach an Elastic IP so the address survives instance restarts