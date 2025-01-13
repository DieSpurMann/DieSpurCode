<script>
    let links = [
      { name: "Maison", href: "/" },
      { name: "CV", href: "/about" },
      { name: "Projets", href: "/projets" },
      { name: "Contact", href: "contact" }
    ];
  </script>
  
  <style>
    nav {
      background-color: #062A77; /* Blue background */
      color: #FFF;
      display: flex;
      justify-content: space-evenly;
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
      color: #FFF;
      text-decoration: none;
      font-weight: thin;
      transition: color 0.3s;
    }
    a:hover {
      color: #ED9122;
      font-weight: bolder;
    }
  </style>
  
  <nav>
    <ul>
      {#each links as link}
        <li><a href={link.href}>{link.name}</a></li>
      {/each}
    </ul>
  </nav>
  