# Local AI LLM Installation

## 1. Overview

This project enables you to set up a local installation similar to ChatGPT or Gemini, providing an interface to connect to any AI APIs, whether hosted in the cloud or run locally. By utilizing Open-WebUI and LiteLLM as an API proxy along with other necessary services, you can create your own customized GPT on a low-performance device. The setup is designed to be user-friendly, even for those with basic IT knowledge.

By integrating Cloudflare and an own subdomain, this GPT can be securely accessed from anywhere, including mobile devices, without requiring complicated IT routing setups or a fast internet connection. This flexibility makes it an ideal solution for personal use, family access, or small businesses looking to leverage AI capabilities without extensive infrastructure.

### 1.1. Security and Privacy Comparison
When comparing this local GPT solution to commercial GPTs, several key benefits regarding security and privacy emerge:

- **Data Control**: With a local installation, you retain full control over your data. Unlike commercial solutions that typically involve sending data to third-party servers for processing, your interactions and usage data remain on your device or network, minimizing exposure to potential data breaches.
- **Privacy**: Commercial GPTs often collect user data for performance improvement and marketing purposes. In contrast, this local solution allows you to interact with your AI without handing over personal information or usage patterns to external entities, ensuring a higher level of privacy.
- **Custom Security Measures**: You can implement tailored security measures that suit your specific needs, such as VPNs, firewalls, and access controls, enhancing the overall security of your AI installation.
- **Reduced Risk of Data Misuse**: Since the AI model operates locally, there’s less risk of your data being misused or sold by commercial entities, offering peace of mind regarding sensitive information.
- **Regulatory Compliance**: For businesses, a local setup can simplify compliance with data protection regulations like GDPR or CCPA, as you have direct control over how personal data is handled and stored.

### 1.2. Additional Benefits:
- **Security**: Utilizing Cloudflare provides enhanced security features, protecting your installation from malicious attacks while allowing encrypted connections.
- **Accessibility**: Users can conveniently access their customized GPT from various devices, ensuring seamless interaction whether at home, on the road, or in the office.
- **Cost-Effective**: Running on low-performance devices reduces hardware costs, making AI technology accessible without hefty investments.
- **Customization**: Tailor your installation to meet specific needs, whether for personal projects or specialized business applications, enriching the user experience.
- **Community Support**: Engage with a growing community of users who share tips, solutions, and improvements, enhancing the overall project’s capabilities.


## 2. Features

- **Local Installation**: Run AI models on your own hardware, minimizing reliance on cloud services.
- **API Proxy**: Seamlessly connect to various AI APIs through Open-WebUI and LiteLLM.
- **Tunnel Access**: Easily connect to your installation remotely for flexible use.
- **Auto-Update Capability**: Keep your services up-to-date automatically without manual intervention.


## 3. Prerequisites

Before starting, make sure your environment meets the following requirements:

- A Unix-based operating system (Linux, macOS).
- An active Internet connection.
- Basic command-line familiarity.
- Docker and Docker Compose
- Cloning the repository


## 4. Get it up and runnig

1. Copy `docker-compose-local.yml` or `docker-compose-web.yml` to `docker-compose.yml`
2. *(Skip this step if you don't want to access the chat from the web)*  
The required simple service at Cloudflare is for free, as Cloudflare is scaled to be used by commercial customers.
    - Register at [Cloudflare](https://www.cloudflare.com/)
    - You need your own Domain which must be managed by Cloudflare.  
    You can buy your own domain for about 11$ p.a. directly at Cloudflare.
    - Go to the menu "Zero Trust" and enter the zone.
    - Under "Networks" -> "Tunnels" you can create a new secure "Cloudflared" tunnel and follow the instructions.
        - Enter a name
        - At connector installation you can choose any, as you need only the token from the provided command.
        - Create a public hostname (Subdomain) like "gpt.mydomain.net"
        - The Service type should be https pointing exactly to "**`traefik:443`**" => `https://traefik:443`
        - At advanced settings please check "**No TLS Check**"
2. Copy `.env-example` to `.env`
3. Set the values in `.env`
4. Start `sudo docker compose up -d`


That's it! Copy the Token, remember the subdomain and the domain and let's start the setup.


