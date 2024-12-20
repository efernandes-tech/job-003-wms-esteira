using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace ExemploWebApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ExemploWebApiSoapController : Controller
{
    private readonly IConfiguration _configuration;

    public ExemploWebApiSoapController(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    [HttpPost]
    [Consumes("application/xml")]
    public async Task<IActionResult> ReceiveSoapXml()
    {
        using (var reader = new StreamReader(Request.Body))
        {
            var conteudoXml = await reader.ReadToEndAsync();

            if (string.IsNullOrEmpty(conteudoXml))
                return BadRequest("XML obrigatório");

            try
            {
                await SaveXmlToDatabase(conteudoXml);

                return Ok("XML processado");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Falha na operação: {ex.Message}");
            }
        }
    }

    private async Task SaveXmlToDatabase(string conteudoXml)
    {
        string connectionString = _configuration.GetConnectionString("DefaultConnection");

        using (var connection = new SqlConnection(connectionString))
        {
            using (var command = new SqlCommand("spSalvarXML", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@XmlConteudo", conteudoXml);

                connection.Open();
                await command.ExecuteNonQueryAsync();
            }
        }
    }
}