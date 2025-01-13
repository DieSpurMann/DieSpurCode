<script>
  import Navbar from '../../lib/Navbar.svelte';    
</script>
  
<Navbar />
<slot />

<style>
  main {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
    color: #625355;
  }
  h1 {
    color: #FF8000; /* Blue color for the header */
    font-weight: 885;
  }
  form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    width: 100%;
    max-width: 400px;
  }
  input, textarea {
    padding: 0.5rem;
    border: 1px solid #000;
    border-radius: 10px;
    background-color: #E4E4E4;
  }
  button {
    padding: 0.5rem;
    background-color: #02002E;
    color: #FF8000;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  button:hover {
    background-color: #625355; /* Orange hover effect */
    color: #ED9122;
    font-weight: bold;
  }
</style>

<main>
  <h1>Contactez Moi</h1>
  <form>
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required />

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required />

    <label for="message">Message:</label>
    <textarea id="message" name="message" rows="4" required></textarea>

    <button type="submit">Send</button>
  </form>
</main>