<script>
    let links = [
      { name: "Home", href: "/" },
      { name: "About", href: "/about" },
      { name: "Projects", href: "/projects" },
      { name: "Contact", href: "contact" }
    ];
  </script>
  
  <style>
    nav {
      background-color: #007bff; /* Blue background */
      color: #fff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 2rem;
    }
    ul {
      list-style-type: none;
      display: flex;
      gap: 1.5rem;
    }
    li {
      display: inline;
    }
    a {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s;
    }
    a:hover {
      color: #ff7f00; /* Orange hover effect */
    }
  </style>
  
  <nav>
    <h1>Your Logo</h1>
    <ul>
      {#each links as link}
        <li><a href={link.href}>{link.name}</a></li>
      {/each}
    </ul>
  </nav>
  