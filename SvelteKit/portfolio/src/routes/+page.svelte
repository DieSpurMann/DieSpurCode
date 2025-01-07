<script>
    export let name = "Pierig Malnoë";
    export let profession = "Étudiant à l'IUT de Lannion";
    export let description = "Je suis une personne passionné par l'Automobile, la Data, la Géographie et des sciences autour du Nucléaire";
    import Navbar from '../lib/Navbar.svelte';
</script>

<Navbar />
  
<slot />
  

<style>
    main {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      text-align: center;
      background-color: #fff;
      color: #333;
      font-family: Arial, sans-serif;
      padding: 20px;
    }
    h1 {
      font-size: 2.5em;
      margin-bottom: 0.5em;
    }
    h2 {
      font-size: 1.5em;
      margin-bottom: 1em;
    }
    p {
      font-size: 1em;
      max-width: 600px;
    }
</style>
  
<main>
    <h1>{name}</h1>
    <h2>{profession}</h2>
    <p>{description}</p>
</main>
  