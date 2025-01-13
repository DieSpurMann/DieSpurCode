<script>
    let projects = [
        { name: "Projet Locàpiques", langage: ["PHP", "JavaScript", "HTML", "CSS", "SQL"], description: "Projet de site web pour une entreprise de location de logement saisonier type AirBNB.", image: "https://imgs.search.brave.com/c2p834AWyR2PZsXYtzsFKWQFjV-qlsDpUjxuh3ZpEIw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJhY2Nlc3Mu/Y29tL2Z1bGwvMjYx/Njg3My5qcGc" },
        { name: "Puissance 4", langage: ["C"], description: "Un puissance 4 en langage C.", image: "https://imgs.search.brave.com/c2p834AWyR2PZsXYtzsFKWQFjV-qlsDpUjxuh3ZpEIw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJhY2Nlc3Mu/Y29tL2Z1bGwvMjYx/Njg3My5qcGc" },
    ];
    import Navbar from '../../lib/Navbar.svelte';
    let orientation = "left";
</script>

<Navbar />
<slot />

<style>
    main {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        height: 100vh;
        text-align: center;
        color: #000;
        font-family: "calibri";
        padding: 20px;
    }
    p {
        font-size: 1em;
        max-width: 600px;
        margin: 10px 0;
    }
    h1 {
        color: #FF8000;
        font-size: 2.5em;
        margin-bottom: 0.5em;
        font-weight: bold;
        margin-top: 6.5%;
    }
    section {
        width: 100%;
        margin: 20px 0;
        padding: 20px;
        border-radius: 10px;
    }
    #left {
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: flex-start;
        background-color: aquamarine;
    }
    #right {
        display: flex;
        flex-direction: row-reverse;
        align-items: center;
        justify-content: flex-start;
        background-color: #FF8000;
    }
    #right img, #left img {
        max-width: 150px;
        margin: 0 20px;
        border-radius: 5px;
    }
    h2 {
        margin: 0;
        font-size: 1.5em;
        color: #000;
    }
    ul {
        list-style-type: none;
        padding: 0;
        margin: 10px 0;
    }
    li {
        display: inline;
        margin-right: 10px;
        font-size: 0.9em;
        color: #333;
    }
</style>

<main>
    <h1>Projets</h1>
    {#each projects as project, i}
    <section id={(i % 2 === 0) ? "left" : "right"}>
        <div>
            <h2>{project.name}</h2>
            <p>{project.description}</p>
            <ul>
                {#each project.langage as lang}
                <li>{lang}</li>
                {/each}
            </ul>
        </div>
        <img src={project.image} alt={project.name} />
    </section>
    {/each}
    <h1>Expérience Professionelle</h1>
</main>
