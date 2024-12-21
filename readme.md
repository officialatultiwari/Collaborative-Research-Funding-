

## Project Title
**Collaborative Research Funding**

## Project Description
The **Collaborative Research Funding** platform is a decentralized application (dApp) built using Ethereum smart contracts that allows researchers to create projects, define milestones, and receive funding from contributors. This solution ensures transparency and accountability in how funds are allocated and used by researchers, providing a secure and efficient way for funders to support research.

With the power of blockchain, funders can trust that their contributions will only be used for the intended purposes, while researchers gain autonomy in managing their projects. The contract supports milestone-based funding, where funds are released upon successful completion of project milestones.

## Contract Address
0xcdf0a1119fb5229e2c4168b8bde0da5d8920a774
![image](https://github.com/user-attachments/assets/b7de13ea-5976-4169-bac2-650eed23ce9f)

## Project Vision
The vision of **Collaborative Research Funding** is to create a transparent, decentralized funding ecosystem for research projects. By utilizing blockchain technology, we aim to create a trustless environment where funding decisions are based on clear, verifiable criteria, such as project milestones and fund utilization. Our goal is to remove intermediaries and empower both researchers and funders with the ability to track and manage funds effectively.

In the long run, we aim to extend the platform's functionality to allow for decentralized governance, enabling stakeholders to vote on project milestones, funding releases, and more.

## Key Features

### 1. **Project Creation**
   - **Researchers** can create new research projects by specifying the project's name and total funding goal.
   - Each project has an associated funding goal, and a funding status (`isFunded` and `isCompleted`) to track whether the project has been fully funded and completed.
   - Projects can include multiple milestones, which researchers define as part of their project plan.

### 2. **Fund Contributions**
   - **Funders** can contribute funds to any active project. Contributions are tracked individually per project and per funder.
   - The contract ensures that once a project's funding goal is met, the project is marked as "funded".
   - Contributions can be made until the project is marked as completed.

### 3. **Milestone-based Funding**
   - Researchers can define specific **milestones** for their projects, each with a funding goal.
   - Milestones represent key phases of the research project, and funding is only released when a milestone's funding goal is met.
   - The contract ensures that funds are transferred only when the milestone is achieved, ensuring funds are used appropriately.

### 4. **Automated Fund Distribution**
   - Once a milestone is successfully funded, funds are automatically transferred to the researcher.
   - This eliminates the need for manual intervention, ensuring that funds are promptly and securely allocated when needed.

### 5. **Project Completion**
   - Researchers can mark their project as **completed** once it is funded and all milestones have been achieved.
   - This marks the end of the funding process for that project and ensures no further contributions are possible.

### 6. **Transparency and Trust**
   - All contributions, milestones, and project statuses are visible on the blockchain, ensuring full transparency.
   - This provides contributors with confidence that their funds are being used as intended and allows them to track progress in real time.

### 7. **Governance (Future Scope)**
   - **Decentralized Autonomous Organization (DAO)**: Future enhancements could allow the community of funders and researchers to vote on critical decisions, such as releasing funds for milestones, approving new project milestones, or selecting research projects.
   - A governance mechanism can help ensure that the platform is decentralized and aligned with the interests of all stakeholders.

