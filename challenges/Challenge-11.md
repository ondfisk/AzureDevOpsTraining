# Challenge 11 - Adding local data

[< Previous](./Challenge-10.md) - **[Home](../README.md)** - [Next >](./Challenge-12.md)

This challenge adds data to your application using SQL Server.

## Tasks

- Move *Challenge 11* to *Doing*
- Create new branch to work in.
- Add packages  `Microsoft.EntityframeworkCore.SqlServer` and `Microsoft.EntityframeworkCore.Design`.
- Add a `Movie` and a `Person` class to represent the `Movies` and `People` tables:

    ```csharp
    public class Movie
    {
        public int Id { get; set; }
        public required string Title { get; set; }
        public int? DirectorId { get; set; }
        public Person? Director { get; set; }
        public int Year { get; set; }
    }

    public class Person
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public ICollection<Movie>? DirectedMovies { get; set; }
    }
    ```

- Create a data context class:

    ```csharp
    public class AppDbContext : DbContext
    {
        public DbSet<Movie> Movies => Set<Movie>();
        public DbSet<Person> People => Set<Person>();
        public DataContext(DbContextOptions<AppDbContext> options) : base(options) { }
    }
    ```

- Override the `OnModelCreating` method to specify data constraints:

    ```csharp
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Movie>()
            .HasOne(m => m.Director)
            .WithMany(p => p.DirectedMovies)
            .HasForeignKey(m => m.DirectorId);

        modelBuilder.Entity<Movie>()
            .Property(m => m.Title)
            .HasMaxLength(250);

        modelBuilder.Entity<Person>()
            .Property(p => p.Name)
            .HasMaxLength(100);
    }
    ```

- Append *seed* data to the `OnModelCreating` method:

    ```csharp
    modelBuilder.Entity<Person>().HasData(
        new Person { Id = 1, Name = "Frank Darabont" },
        new Person { Id = 2, Name = "Francis Ford Coppola" },
        new Person { Id = 3, Name = "Christopher Nolan" },
        new Person { Id = 4, Name = "Sidney Lumet" },
        new Person { Id = 5, Name = "Steven Spielberg" },
        new Person { Id = 6, Name = "Peter Jackson" },
        new Person { Id = 7, Name = "Quentin Tarantino" },
        new Person { Id = 8, Name = "Sergio Leone" }
    );

    modelBuilder.Entity<Movie>().HasData(
        new Movie { Id = 1, Title = "The Shawshank Redemption", DirectorId = 1, Year = 1994 },
        new Movie { Id = 2, Title = "The Godfather", DirectorId = 2, Year = 1972 },
        new Movie { Id = 3, Title = "The Dark Knight", DirectorId = 3, Year = 2008 },
        new Movie { Id = 4, Title = "The Godfather Part II", DirectorId = 1, Year = 1974 },
        new Movie { Id = 5, Title = "12 Angry Men", DirectorId = 4, Year = 1957 },
        new Movie { Id = 6, Title = "Schindler's List", DirectorId = 5, Year = 1993 },
        new Movie { Id = 7, Title = "The Lord of the Rings: The Return of the King", DirectorId = 6, Year = 2003 },
        new Movie { Id = 8, Title = "Pulp Fiction", DirectorId = 7, Year = 1994 },
        new Movie { Id = 9, Title = "The Lord of the Rings: The Fellowship of the Ring", DirectorId = 6, Year = 2001 },
        new Movie { Id = 10, Title = "The Good, the Bad and the Ugly", DirectorId = 8, Year = 1966 }
    );
    ```

- Verify that everything builds
- Add a connection string to `appsettings.json`:

    ```json
    {
      "ConnectionStrings": {
        "ConnectionString": "Server=(localdb)\\mssqllocaldb;Database=MyDatabase;Trusted_Connection=True;MultipleActiveResultSets=true"
    },
    ```

- Configure `AppDbContext` in `Program.cs`:

    ```csharp
    builder.Services.AddDbContext<AppDbContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("ConnectionString")));
    ```

- Install EF tools: `dotnet tool install dotnet-ef --global`
- Add migration: `dotnet ef migrations add Initial`
- Apply migration: `dotnet ef database update`
- Create a `MoviesDTO` type to for presentation:

    ```csharp
    public record MovieDTO(int Id, string Title, string Director, int Year);
    ```

- Create a `Movies` page using `Pages/FetchData.razor` as inspiration.

    You will want to add these two lines to the top of the page

    ```csharp
    @using Microsoft.EntityFrameworkCore
    @inject AppDbContext AppDbContext
    ```

    Then you can load your movies with:

    ```csharp
    movies = await AppDbContext.Movies
        .OrderBy(m => m.Title)
        .Select(m => new MovieDTO(m.Id, m.Title, m.Director!.Name, m.Year))
        .ToArrayAsync();
    ```

- Add a link to the `Movies` page in `Pages/NavMenu.razor`
- Create PR and merge.
